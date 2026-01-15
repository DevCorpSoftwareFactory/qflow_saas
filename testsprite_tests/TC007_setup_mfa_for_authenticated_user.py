import requests

def test_setup_mfa_for_authenticated_user():
    base_url = "http://localhost:3000"
    url = f"{base_url}/auth/mfa/setup"
    token = ("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9."
             "eyJzdWIiOiJhODE2ZTI1Yy1lODljLTRmY2EtOGQ2MS1mODk5Y2UxNDEwYmIiLCJ0ZW5hbnRJZCI6IjExMTExMTExLTExMTEtMTExMS0xMTExLTExMTExMTExMTExMSIsImlhdCI6MTc2ODQ0Njg3OCwiZXhwIjoxNzY5MDUxNjc4fQ."
             "ipi_MNMLeB6iJbCBGX-UsztZKEi-GkIbONLYyKBKosI")
    headers = {
        "Authorization": f"Bearer {token}"
    }
    try:
        response = requests.post(url, headers=headers, timeout=30)
        assert response.status_code == 200, f"Expected 200 OK but got {response.status_code}"
        json_data = response.json()
        assert "qrCodeUrl" in json_data, "Response JSON missing 'qrCodeUrl'"
        assert isinstance(json_data["qrCodeUrl"], str) and json_data["qrCodeUrl"], "'qrCodeUrl' should be a non-empty string"
        assert "secret" in json_data, "Response JSON missing 'secret'"
        assert isinstance(json_data["secret"], str) and json_data["secret"], "'secret' should be a non-empty string"
    except requests.RequestException as e:
        assert False, f"Request failed: {e}"

test_setup_mfa_for_authenticated_user()