import requests

def test_login_user_with_correct_credentials():
    base_url = "http://localhost:3000"
    endpoint = "/auth/login"
    url = base_url + endpoint
    payload = {
        "email": "testsprite@qflow.com",
        "password": "TestSprite123!"
    }
    headers = {
        "Content-Type": "application/json"
    }
    try:
        response = requests.post(url, json=payload, headers=headers, timeout=30)
    except requests.RequestException as e:
        assert False, f"Request failed: {e}"

    assert response.status_code == 200, f"Expected status code 200, got {response.status_code}"
    try:
        data = response.json()
    except ValueError:
        assert False, "Response is not valid JSON"

    assert "accessToken" in data, "Response JSON does not contain 'accessToken'"
    assert isinstance(data["accessToken"], str) and data["accessToken"], "'accessToken' should be a non-empty string"

test_login_user_with_correct_credentials()