import requests

BASE_URL = "http://localhost:3000"
EMAIL = "testsprite@qflow.com"
PASSWORD = "TestSprite123!"
TENANT_ID = "11111111-1111-1111-1111-111111111111"
BRANCH_ID = "33333333-3333-3333-3333-333333333333"
VARIANT_ID = "66666666-6666-6666-6666-666666666666"
CASHIER_ID = "ecdbde1b-223a-406f-89af-54b6799517bc"
PAYMENT_METHOD = "cash"
TIMEOUT = 30


def test_create_sale_with_valid_data_and_sufficient_stock():
    session = requests.Session()
    try:
        # Login to get JWT token
        login_payload = {"email": EMAIL, "password": PASSWORD}
        login_resp = session.post(f"{BASE_URL}/auth/login", json=login_payload, timeout=TIMEOUT)
        assert login_resp.status_code == 200, f"Login failed with status {login_resp.status_code}"
        token = login_resp.json().get("accessToken")
        assert token, "No accessToken in login response"

        headers = {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json"
        }

        # Check stock availability (quantity=1 for test)
        check_stock_payload = {
            "variantId": VARIANT_ID,
            "branchId": BRANCH_ID,
            "quantity": 1
        }
        stock_resp = session.post(f"{BASE_URL}/inventory/check-availability", json=check_stock_payload, headers=headers, timeout=TIMEOUT)
        assert stock_resp.status_code == 200, f"Stock availability check failed with status {stock_resp.status_code}"
        availability_data = stock_resp.json()
        # We expect availability confirmation (depending on actual API response shape)
        # Typical success response could have e.g. {"available": true}
        available = availability_data.get("available")  # Could be named differently
        assert available is True, f"Stock not available for variantId {VARIANT_ID} at branchId {BRANCH_ID}"

        # Create sale with valid data and sufficient stock
        sale_payload = {
            "branchId": BRANCH_ID,
            "cashierId": CASHIER_ID,
            "paymentMethod": PAYMENT_METHOD,
            "items": [
                {
                    "variantId": VARIANT_ID,
                    "quantity": 1,
                    "unitPrice": 10.0
                }
            ]
        }
        sale_resp = session.post(f"{BASE_URL}/sales", json=sale_payload, headers=headers, timeout=TIMEOUT)
        assert sale_resp.status_code == 201, f"Sale creation failed with status {sale_resp.status_code}"

    finally:
        session.close()


test_create_sale_with_valid_data_and_sufficient_stock()