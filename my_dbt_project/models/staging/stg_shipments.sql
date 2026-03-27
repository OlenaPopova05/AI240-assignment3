with source as (

    select *
    from {{ ref('raw_shipments') }}

),

renamed as (

    select
        cast(shipment_id as bigint) as shipment_id,
        cast(order_id as bigint) as order_id,
        cast(shipment_date as date) as shipment_date,
        cast(nullif(delivery_date, '') as date) as delivery_date,
        lower(trim(shipment_status)) as shipment_status,
        trim(carrier) as carrier,
        cast(shipping_cost as decimal(18,2)) as shipping_cost

    from source

),

final as (

    select
        shipment_id,
        order_id,
        shipment_date,
        delivery_date,
        shipment_status,
        carrier,
        shipping_cost,
        case
            when delivery_date is not null then delivery_date - shipment_date
            else null
        end as delivery_days

    from renamed

)

select *
from final
