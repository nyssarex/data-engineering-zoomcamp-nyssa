import pandas as pd
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    
    #data['passenger_count'].fillna(0,inplace=True)
    #data['trip_distance'].fillna(0,inplace=True)
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    data = data.rename(columns={
        'VendorID':	'vendor_id',
        'RatecodeID': 'ratecode_id'	,
        'PULocationID':	'pu_location_id',
        'DOLocationID':	'do_location_id'})
    print(len(data[(data.passenger_count>0) & (data.trip_distance>0)]))
    return data[(data.passenger_count>0) & (data.trip_distance>0)]


@test
def test_output(output, *args) -> None:
    
    assert output['vendor_id'].isin([1,2]).all(),'Vendor id is okay'
    assert output.passenger_count.isin([0]).sum()==0, 'The are trips with zero passengers'
    assert 'vendor_id' in output.columns,'strange things is going here'
    assert output.trip_distance.isin([0]).sum()==0, 'The are trips with zero trip distance'
