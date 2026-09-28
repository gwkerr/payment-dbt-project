from datetime import datetime

from airflow import DAG
from airflow.providers.standard.operators.bash import BashOperator


DBT_PROJECT = "/Users/gavinkerr/Desktop/creations/dbt_demo/payment_dbt"
DBT_PROFILES = "/Users/gavinkerr/.dbt"


with DAG(
    dag_id="payment_analytics_pipeline",
    description="End-to-end Snowflake and dbt payment analytics pipeline",
    start_date=datetime(2026, 1, 1),
    schedule=None,
    catchup=False,
    tags=["dbt", "snowflake", "payments"],
) as dag:
    load_new_payment = BashOperator(
        task_id="load_new_payment",
        bash_command=(
            f"cd {DBT_PROJECT} && "
            "python scripts/load_payment.py"
        ),
    )
    dbt_debug = BashOperator(
        task_id="dbt_debug",
        bash_command=(
            f"cd {DBT_PROJECT} && "
            f"dbt debug --profiles-dir {DBT_PROFILES}"
        ),
    )

    dbt_snapshot = BashOperator(
        task_id="dbt_snapshot",
        bash_command=(
            f"cd {DBT_PROJECT} && "
            f"dbt snapshot --profiles-dir {DBT_PROFILES}"
        ),
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command=(
            f"cd {DBT_PROJECT} && "
            f"dbt run --profiles-dir {DBT_PROFILES}"
        ),
    )

    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command=(
            f"cd {DBT_PROJECT} && "
            f"dbt test --profiles-dir {DBT_PROFILES}"
        ),
    )

    load_new_payment >> dbt_debug >> dbt_snapshot >> dbt_run >> dbt_test
