import requests

BASE_URL = "http://localhost:3000"
REGISTER_ENDPOINT = f"{BASE_URL}/auth/register"
TIMEOUT = 30

# Use an existing email to test duplicate registration
EXISTING_EMAIL = "testsprite@qflow.com"
PASSWORD = "TestSprite123!"
FULL_NAME = "Test Sprite"
TENANT_ID = "11111111-1111-1111-1111-111111111111"
ROLE_ID = "00000000-0000-0000-0000-000000000000"  # Assuming a placeholder roleId for the test


def test_handle_duplicate_user_registration():
    # Payload with an existing email that is already registered
    payload = {
        "email": EXISTING_EMAIL,
        "password": PASSWORD,
        "fullName": FULL_NAME,
        "tenantId": TENANT_ID,
        "roleId": ROLE_ID,
    }
    headers = {"Content-Type": "application/json"}

    try:
        response = requests.post(
            REGISTER_ENDPOINT, json=payload, headers=headers, timeout=TIMEOUT
        )
    except requests.RequestException as e:
        assert False, f"Request to register endpoint failed: {e}"

    # Validate the response status code is 409 Conflict indicating user already exists
    assert response.status_code == 409, (
        f"Expected status code 409 for duplicate registration, "
        f"got {response.status_code} with response: {response.text}"
    )


test_handle_duplicate_user_registration()