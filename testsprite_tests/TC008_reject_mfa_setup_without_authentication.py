import requests

BASE_URL = "http://localhost:3000"
TIMEOUT = 30

def test_reject_mfa_setup_without_authentication():
    url = f"{BASE_URL}/auth/mfa/setup"
    headers = {
        "Content-Type": "application/json"
    }

    try:
        response = requests.post(url, headers=headers, timeout=TIMEOUT)
    except requests.RequestException as e:
        assert False, f"Request failed: {e}"

    assert response.status_code == 401, f"Expected status code 401, got {response.status_code}"

test_reject_mfa_setup_without_authentication()