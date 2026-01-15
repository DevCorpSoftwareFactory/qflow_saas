import requests

def test_handle_duplicate_user_registration_gracefully():
    base_url = "http://localhost:3000"
    register_endpoint = f"{base_url}/auth/register"
    headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhODE2ZTI1Yy1lODljLTRmY2EtOGQ2MS1mODk5Y2UxNDEwYmIiLCJ0ZW5hbnRJZCI6IjExMTExMTExLTExMTEtMTExMS0xMTExLTExMTExMTExMTExMSIsImlhdCI6MTc2ODQ0Njg3OCwiZXhwIjoxNzY5MDUxNjc4fQ.ipi_MNMLeB6iJbCBGX-UsztZKEi-GkIbONLYyKBKosI"
    }
    # Using the given existing user's details for email, tenantId and roleId
    payload = {
        "email": "testsprite@qflow.com",
        "password": "TestSprite123!",
        "fullName": "Test Sprite",
        "tenantId": "11111111-1111-1111-1111-111111111111",
        "roleId": "22222222-2222-2222-2222-222222222222"
    }

    try:
        response = requests.post(register_endpoint, json=payload, headers=headers, timeout=30)
    except requests.RequestException as e:
        assert False, f"Request failed: {e}"

    # Verify response status code is 409 Conflict because user already exists
    assert response.status_code == 409, f"Expected status 409 but got {response.status_code}"

test_handle_duplicate_user_registration_gracefully()