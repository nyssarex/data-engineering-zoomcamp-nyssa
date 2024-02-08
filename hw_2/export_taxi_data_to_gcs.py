import pyarrow as pa
import pyarrow.parquet as pq
import os 


if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


os.environ['GOOGLE_APPLICATION_CREDENTIALS']= '/home/src/keys/keys.json'
bucket_name = 'rare_sound_412302_bucket'
project_id = 'rare-sound-412302'
table_name = 'nyc_taxi_data'

root_path = f"{bucket_name}/{table_name}"
@data_exporter
def export_data(data, *args, **kwargs):
    
    table = pa.Table.from_pandas(data)

    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols =['lpep_pickup_date'],
        filesystem=gcs
    )


