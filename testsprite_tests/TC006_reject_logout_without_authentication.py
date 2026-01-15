import requests

BASE_URL = "http://localhost:3000"


def test_reject_logout_without_authentication():
    url = f"{BASE_URL}/auth/logout"
    headers = {
        # Intentionally no Authorization header to test unauthorized access
    }
    try:
        response = requests.post(url, headers=headers, timeout=30)
        assert response.status_code == 401, f"Expected 401 Unauthorized, got {response.status_code}"
    except requests.RequestException as e:
        assert False, f"Request failed with exception: {e}"


test_reject_logout_without_authentication()