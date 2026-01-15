import requests

BASE_URL = "http://localhost:3000"
LOGIN_EMAIL = "testsprite@qflow.com"
LOGIN_PASSWORD = "TestSprite123!"
TIMEOUT = 30

def test_logout_authenticated_user_successfully():
    # Step 1: Login to get valid bearer token
    login_url = f"{BASE_URL}/auth/login"
    login_payload = {
        "email": LOGIN_EMAIL,
        "password": LOGIN_PASSWORD
    }
    try:
        login_response = requests.post(login_url, json=login_payload, timeout=TIMEOUT)
        assert login_response.status_code == 200, f"Login failed with status {login_response.status_code}"
        login_data = login_response.json()
        access_token = login_data.get("accessToken")
        assert access_token is not None, "No accessToken in login response"
    except Exception as e:
        raise Exception(f"Login request failed: {e}")

    # Step 2: Logout with bearer token
    logout_url = f"{BASE_URL}/auth/logout"
    headers = {
        "Authorization": f"Bearer {access_token}"
    }
    try:
        logout_response = requests.post(logout_url, headers=headers, timeout=TIMEOUT)
        assert logout_response.status_code == 200, f"Logout failed with status {logout_response.status_code}"
    except Exception as e:
        raise Exception(f"Logout request failed: {e}")


test_logout_authenticated_user_successfully()