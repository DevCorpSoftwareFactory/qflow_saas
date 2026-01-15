import requests

def test_reject_login_with_invalid_credentials():
    base_url = "http://localhost:3000"
    endpoint = "/auth/login"
    url = base_url + endpoint
    headers = {
        "Content-Type": "application/json"
    }

    # Test with incorrect email
    invalid_email_payload = {
        "email": "wrongemail@qflow.com",
        "password": "TestSprite123!"
    }

    try:
        response = requests.post(url, json=invalid_email_payload, headers=headers, timeout=30)
        assert response.status_code == 401, f"Expected 401 but got {response.status_code} for invalid email"
    except requests.RequestException as e:
        assert False, f"Request failed: {e}"

    # Test with incorrect password
    invalid_password_payload = {
        "email": "testsprite@qflow.com",
        "password": "WrongPassword!"
    }

    try:
        response = requests.post(url, json=invalid_password_payload, headers=headers, timeout=30)
        assert response.status_code == 401, f"Expected 401 but got {response.status_code} for invalid password"
    except requests.RequestException as e:
        assert False, f"Request failed: {e}"

test_reject_login_with_invalid_credentials()