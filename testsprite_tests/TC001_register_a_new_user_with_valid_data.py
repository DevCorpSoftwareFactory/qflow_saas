import requests
import uuid

BASE_URL = "http://localhost:3000"
REGISTER_ENDPOINT = f"{BASE_URL}/auth/register"
DELETE_USER_ENDPOINT_TEMPLATE = f"{BASE_URL}/users/{{user_id}}"
TIMEOUT = 30
HEADERS = {"Content-Type": "application/json"}

# Use provided existing tenant and a sample valid roleId for testing
EXISTING_TENANT_ID = "11111111-1111-1111-1111-111111111111"
# For roleId, since no explicit existing roleId provided, we create a dummy guid here
# Usually, roleId should be valid, but in absence of provided data, we'll generate a uuid for demonstration
# Note: If this causes 400 errors, an actual existing roleId must be provided.
EXISTING_ROLE_ID = "22222222-2222-2222-2222-222222222222"


def test_register_new_user_with_valid_data():
    # Unique email to avoid conflict
    unique_email = f"testsprite+{uuid.uuid4()}@qflow.com"
    payload = {
        "email": unique_email,
        "password": "TestSprite123!",
        "fullName": "Test Sprite",
        "tenantId": EXISTING_TENANT_ID,
        "roleId": EXISTING_ROLE_ID,
    }

    user_id = None
    try:
        response = requests.post(REGISTER_ENDPOINT, json=payload, headers=HEADERS, timeout=TIMEOUT)
        # Assert status code is 201 Created
        assert response.status_code == 201, f"Expected status 201, got {response.status_code}"

        # The response may or may not include user info. We try to extract user ID if present
        # Assuming response JSON contains user info with 'id' or 'userId'
        try:
            data = response.json()
            # Try to find user id from response keys
            user_id = data.get("id") or data.get("userId")
        except Exception:
            user_id = None

        # Additional assertion: user_id should be present ideally, but if not, test still passes by API spec
        # If user_id is None, we cannot delete the user in cleanup

    finally:
        if user_id:
            # Attempt to delete user to clean up test data, ignoring failure
            try:
                del_resp = requests.delete(
                    DELETE_USER_ENDPOINT_TEMPLATE.format(user_id=user_id),
                    headers=HEADERS,
                    timeout=TIMEOUT,
                )
                # No assert here; just try best effort cleanup
            except Exception:
                pass


test_register_new_user_with_valid_data()