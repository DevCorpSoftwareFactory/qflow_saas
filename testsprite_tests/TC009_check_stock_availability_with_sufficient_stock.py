import requests

BASE_URL = "http://localhost:3000"
TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhODE2ZTI1Yy1lODljLTRmY2EtOGQ2MS1mODk5Y2UxNDEwYmIiLCJ0ZW5hbnRJZCI6IjExMTExMTExLTExMTEtMTExMS0xMTExLTExMTExMTExMTExMSIsImlhdCI6MTc2ODQ0Njg3OCwiZXhwIjoxNzY5MDUxNjc4fQ.ipi_MNMLeB6iJbCBGX-UsztZKEi-GkIbONLYyKBKosI"
VARIANT_ID = "66666666-6666-6666-6666-666666666666"
BRANCH_ID = "33333333-3333-3333-3333-333333333333"
TIMEOUT = 30


def test_check_stock_availability_with_sufficient_stock():
    url = f"{BASE_URL}/inventory/check-availability"
    headers = {
        "Authorization": f"Bearer {TOKEN}",
        "Content-Type": "application/json",
        "Accept": "application/json"
    }
    payload = {
        "variantId": VARIANT_ID,
        "branchId": BRANCH_ID,
        "quantity": 50  # less than available stock 100
    }
    try:
        response = requests.post(url, json=payload, headers=headers, timeout=TIMEOUT)
    except requests.RequestException as e:
        assert False, f"Request failed: {e}"

    assert response.status_code == 200, f"Expected status code 200 but got {response.status_code}"
    try:
        data = response.json()
    except ValueError:
        assert False, "Response is not a valid JSON"

    # We expect a key or property indicating stock availability status
    # Since PRD doesn't specify exact response schema, check for a plausible confirmation
    # For example, response might have {"available": true} or similar
    assert ("available" in data and data["available"] is True) or \
           ("isAvailable" in data and data["isAvailable"] is True), \
           f"Expected availability confirmed in response but got {data}"

test_check_stock_availability_with_sufficient_stock()