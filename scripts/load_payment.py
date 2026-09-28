import os
import uuid
import snowflake.connector


conn = snowflake.connector.connect(
    account=os.environ["SNOWFLAKE_ACCOUNT"],
    user=os.environ["SNOWFLAKE_USER"],
    password=os.environ["SNOWFLAKE_PASSWORD"],
    warehouse="COMPUTE_WH",
    database="PAYMENT_ANALYTICS",
    schema="RAW",
)

payment_id = "AIRFLOW_" + uuid.uuid4().hex[:8].upper()

sql = """
INSERT INTO PAYMENT_ANALYTICS.RAW.PAYMENTS
(
    payment_id,
    account_id,
    merchant_id,
    amount,
    currency,
    status,
    payment_date
)
VALUES
(
    %s,
    'A1001',
    'M001',
    199.99,
    'USD',
    'COMPLETED',
    CURRENT_DATE()
)
"""

try:
    cursor = conn.cursor()

    cursor.execute(sql, (payment_id,))

    print(f"Successfully loaded payment: {payment_id}")

finally:
    conn.close()
