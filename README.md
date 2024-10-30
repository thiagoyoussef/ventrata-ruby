# Ventrata Ruby

Ruby wrapper for the [Ventrata API](https://docs.ventrata.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ventrata'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ventrata

## Usage

### Table of Contents

- [Authentication](#authentication)
- [Suppliers](#suppliers)
- [Products](#products)
- [Availability](#availability)
- [Bookings](#bookings)
- [Webhook](#webhook)
- [Mapping](#mapping)
- [Order](#order)
- [Gift](#gift)
- [Redemption](#redemption)
- [Checkin](#checkin)
- [Identity](#identity)

### Authentication

OCTO uses Bearer authentication. To authenticate your requests, get the API key in Ventrata and set `Ventrata.api_key` to its value:

```ruby
Ventrata.api_key = '5bd1629a-323e-4edb-ac9b-327ef51e6136'
```

### Suppliers

#### List Suppliers

Returns a list of suppliers and associated contact details based on the suppliers your API Key has access. This will be a single supplier per API key in Ventrata's implementation.

```ruby
Ventrata::Supplier.list
```

##### Capabilities

- content

```ruby
Ventrata::Supplier.list(capabilities: [:content])
```

#### Get Supplier

Returns the supplier and associated details.

```ruby
Ventrata::Supplier.retrieve('id')
```

##### Capabilities

- content

```ruby
Ventrata::Supplier.retrieve('id', capabilities: [:content])
```

### Products

#### List Products

List all the products available for sale.

```ruby
Ventrata::Product.list
```

Query Parameters:

```ruby
Ventrata::Product.list(categoryId: 'The category id to filter the products by', destinationId: 'The destination id to filter the products by')
```

Capabilities:

- pricing
- content
- packages
- redemption

```ruby
Ventrata::Product.list(capabilities: [:pricing, :content, :packages, :redemption])
```

#### Get Product

Returns the supplier and associated details.

```ruby
Ventrata::Product.retrieve('id')
```

##### Capabilities

- pricing
- content
- pickups
- questions
- extras

Query Parameters:

- pickupRequested (pickups)

```ruby
Ventrata::Product.retrieve('id', pickupRequested: true, capabilities: [:pricing, :content, :pickups, :extras])
```

### Availability

#### Calendar

The availability calendar endpoint for quick retrieval of availability over a date range.

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  localDateStart: "2020-07-01",
  localDateEnd: "2020-07-03",
  units: [
    { id: "unit_123abcadult", quantity: 2 },
    { id: "unit_321abcchild", quantity: 1 }
  ]
}

Ventrata::Availability.calendar(body)
```

##### Capabilities

- pricing
- content

Body:

- currency (pricing)

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  localDateStart: "2020-07-01",
  localDateEnd: "2020-07-03",
  units: [
    { id: "unit_123abcadult", quantity: 2 },
    { id: "unit_321abcchild", quantity: 1 }
  ],
  currency: 'USD',
  capabilities: [:pricing, :content]
}

Ventrata::Availability.calendar(body)
```

#### Availability Check

Get final availability for a given product. If in doubt between the calendar endpoint and this one, you should use this endpoint.

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  localDateStart: "2020-07-01",
  localDateEnd: "2020-07-03",
  units: [
    { id: "unit_123abcadult", quantity: 2 },
    { id: "unit_321abcchild", quantity: 1 }
  ]
}

Ventrata::Availability.check(body)
```

##### Capabilities

- pricing
- content
- pickups
- offers
- extras

Body:

- currency (pricing)
- pickupRequested (pickups)
- pickupPointId (pickups)
- offerCode (offers)

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  localDateStart: "2020-07-01",
  localDateEnd: "2020-07-03",
  units: [
    { id: "unit_123abcadult", quantity: 2 },
    { id: "unit_321abcchild", quantity: 1 }
  ],
  currency: 'USD',
  pickupRequested: 'Whether the customer requested pickup',
  pickupPointId: 'The pickup point id selected',
  offerCode: 'The offer code you want to use'
  capabilities: [:pricing, :content, :pickups, :offers, :extras]
}

Ventrata::Availability.check(body)
```

#### Check Available Resources

Get final availability for a given product. If in doubt between the calendar endpoint and this one, you should use this endpoint.

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  localDateStart: "2020-07-01",
  localDateEnd: "2020-07-03",
  units: [
    { id: "unit_123abcadult", quantity: 2 },
    { id: "unit_321abcchild", quantity: 1 }
  ]
}

Ventrata::Availability.resources(body)
```

##### Capabilities

- resources (required)

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  availabilityId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  units: [
    { id: "unit_123abcadult", quantity: 2 }
  ],
  capabilities: [:resources]
}

Ventrata::Availability.resources(body)
```

### Bookings

#### List Bookings

List bookings in the system given certain parameters.

```ruby
params = {
  resellerReference: 'The reseller reference on the booking',
  supplierReference: 'The reference provided by the supplier',
  localDate: 'All bookings made for a specific date',
  localDateStart: 'First date of a date range search',
  localDateEnd: 'Last date of a date range search',
  productId: 'The product id to filter by',
  optionId: 'The option id to filter by'
}

Ventrata::Booking.list(params)
```

Capabilities:

- pricing

```ruby
Ventrata::Booking.list(capabilities: [:pricing])
```

#### Get Booking

Fetch the status of an existing booking.

```ruby
Ventrata::Booking.retrieve('uuid')
```

##### Capabilities

- pickups
- offers
- checkin

```ruby
Ventrata::Booking.retrieve('uuid', capabilities: [:pickups, :offers, :checkin])
```

#### Booking Reservation

The first step is to reserve the availability by creating the booking.

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  availabilityId: "2020-07-01T14:30:00-05:00",
  notes: "Optional notes for the booking",
  unitItems: [
    { unitId: "unit_123abcadult" },
    { unitId: "unit_123abcadult" },
    { unitId: "unit_321abcchild" }
  ]
}

Ventrata::Booking.create(body)
```

##### Capabilities

- pricing
- pickups
- questions
- extras
- adjustments
- cart
- packages
- identities

Body:

- currency (pricing)
- pickupRequested (pickups)
- pickupPointId (pickups)
- pickupHotel (pickups)
- pickupHotelRoom (pickups)
- adjustments (adjustments)
- identityId (identities)
- identityKey (identities)

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  availabilityId: "2020-07-01T14:30:00-05:00",
  notes: "Optional notes for the booking",
  unitItems: [
    { unitId: "unit_123abcadult" },
    { unitId: "unit_123abcadult" },
    { unitId: "unit_321abcchild" }
  ],
  currency: 'USD',
  pickupRequested: 'Whether the customer requested pickup',
  pickupPointId: 'The id of the chosen pickup point',
  pickupHotel: 'The hotel address (optional)',
  pickupHotelRoom: 'The hotel room number (optional)',
  adjustments: ['The adjustments to add to the booking'],
  identityId: 'identityId',
  identityKey: 'identityKey',
  capabilities: [:pricing, :pickups, :questions, :extras, :adjustments, :cart, :packages, :identities]
}

Ventrata::Booking.create(body)
```

#### Booking Update

This endpoint allows you to update an existing booking. The request parameters are the same as the booking reservation endpoint.

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  availabilityId: "2020-07-01T14:30:00-05:00",
  notes: "Optional notes for the booking",
  unitItems: [
    { unitId: "unit_123abcadult" },
    { unitId: "unit_123abcadult" },
    { unitId: "unit_321abcchild" }
  ]
}

Ventrata::Booking.update('uuid', body)
```

##### Capabilities

- offers
- packages

Body:

- offerCode (offers)

```ruby
body = {
  productId: "1a7213eb-3a33-4cbb-b114-64d771c201ac",
  optionId: "DEFAULT",
  availabilityId: "2020-07-01T14:30:00-05:00",
  notes: "Optional notes for the booking",
  unitItems: [
    { unitId: "unit_123abcadult" },
    { unitId: "unit_123abcadult" },
    { unitId: "unit_321abcchild" }
  ],
  offerCode: 'The promotion code',
  capabilities: [:offers, :packages]
}

Ventrata::Booking.update('uuid', body)
```

#### Booking Confirmation

This endpoint confirms the booking so it's ready to be used.

```ruby
body = {
  resellerReference: "VOUCHER-0123",
  contact: {
    fullName: "Oliver Morgan",
    emailAddress: "ollym@me.com",
    phoneNumber: "+447840739436",
    locales: ["en-GB", "en-US", "en"],
    country: "GB"
  }
}

Ventrata::Booking.confirm('uuid', body)
```

#### Booking Cancellation

If the booking is confirmed this endpoint will cancel it, otherwise it will release the availability that was put on hold.

```ruby
Ventrata::Booking.cancel('uuid', reason: 'cancel reason')
```

#### Extend Reservation

Use this method to hold the availability for a booking longer if the status is `ON_HOLD`.

```ruby
Ventrata::Booking.extend('uuid', expirationMinutes: 60)
```

### Webhook

By default, all `Ventrata::Webhook` requests add capabality `octo/webhooks` to your `Octo-Capabilities` header.

#### List Webhooks

List all webhooks.

```ruby
Ventrata::Webhook.list
```

#### Create a Webhook

Create a new webhook.

```ruby
body = {
  event: "booking_update",
  url: "https://example.com/webhooks/availability_update"
}

Ventrata::Webhook.create(body)
```

#### Delete Webhooks

Delete an existing webhook.

```ruby
Ventrata::Webhook.destroy('id')
```

### Mapping

By default, all `Ventrata::Mapping` requests add capabality `octo/mappings` to your `Octo-Capabilities` header.

#### List Mappings

Gets the current state of all the mappings in the system.

```ruby
Ventrata::Mapping.list
```

#### Update Mappings

Send to us a list of all your product listings and what mapping fields you need in response. We'll then call the provided webhookUrl when the data is updated.

```ruby
Ventrata::Mapping.update
```

### Order

By default, all `Ventrata::Order` requests add capabality `octo/cart` to your `Octo-Capabilities` header.

#### Get Order

A convenient method to retrieve an existing order.

```ruby
Ventrata::Order.retrieve('id')
```

##### Capabilities

- offers

```ruby
Ventrata::Order.retrieve('id', capabilities: [:offers])
```

#### Create Order

Using this endpoint is optional if you prefer to create the order first before creating your first booking.

```ruby
Ventrata::Order.create(currency: 'USD', expirationMinutes: 60)
```

##### Capabilities

- identities

Body:

- identityId (identities)
- identityKey (identities)

```ruby
Ventrata::Order.create(identityId: 'identityId', identityKey: 'identityKey', capabilities: [:identities])
```

#### Extend Order

If the order has a status of ON_HOLD and you need more time before confirming the order.

```ruby
Ventrata::Order.extend('id', expirationMinutes: 60)
```

#### Order Confirmation

Confirm the order and all the bookings it contains.

```ruby
body = {
  contact: {
    fullName: "Oliver Morgan",
    emailAddress: "ollym@me.com",
    phoneNumber: "+447840739436",
    locales: ["en-GB", "en-US", "en"],
    country: "GB"
  }
}

Ventrata::Order.confirm('id', body)
```

#### Order Cancellation

This cancels the order and any bookings inside it.

```ruby
Ventrata::Order.cancel('id', reason: 'cancel reason')
```

### Gift

By default, all `Ventrata::Gift` requests add capabality `octo/gifts` to your `Octo-Capabilities` header.

#### List Gifts

When using this endpoint you must include one of the following parameters:

- resellerReference
- supplierReference

The results aren't paginated as the result set will never be too long because of the required filters.

```ruby
Ventrata::Gift.list(resellerReference: '123123', supplierReference: '123123')
```

#### Get Gift

This endpoint will fetch the gift voucher with the provided UUID from the system.

```ruby
Ventrata::Gift.retrieve('uuid')
```

#### Gift Reservation

```ruby
body = {
  amount: 1000,
  currency: "USD",
  message: "Happy Birthday! Hope you enjoy your trip to Paris!",
  recipient: {
    fullName: "Oliver Morgan",
    emailAddress: "ollym@me.com"
  }
}

Ventrata::Gift.create(body)
```

##### Capabilities

- identities

Body:

- identityId (identities)
- identityKey (identities)

```ruby
body = {
  amount: 1000,
  currency: "USD",
  message: "Happy Birthday! Hope you enjoy your trip to Paris!",
  recipient: {
    fullName: "Oliver Morgan",
    emailAddress: "ollym@me.com"
  },
  identityId: 'identityId',
  identityKey: 'identityKey',
  capabilities: [:identities]
}

Ventrata::Gift.create(body)
```

#### Gift Update

```ruby
body = {
  amount: 1000,
  currency: "USD",
  message: "Happy Birthday! Hope you enjoy your trip to Paris!",
  recipient: {
    fullName: "Oliver Morgan",
    emailAddress: "ollym@me.com"
  }
}

Ventrata::Gift.update('uuid', body)
```

#### Gift Confirmation

```ruby
Ventrata::Gift.confirm('uuid')
```

#### Gift Cancellation

```ruby
Ventrata::Gift.cancel('uuid', reason: 'cancel reason')
```

#### Extend Gift

```ruby
Ventrata::Gift.extend('uuid', expirationMinutes: 60)
```

### Redemption

By default, all `Ventrata::Redemption` requests add capabality `octo/redemption` to your `Octo-Capabilities` header.

#### Lookup

Finds all matching bookings given a scanned code (reference). This can either be a barcode or reference number. From the input we'll attempt to locate all matching bookings and return them in the response.

```ruby
Ventrata::Redemption.lookup(reference: "The reference/barcode you're looking up")
```

#### Redeem

Once you've chosen a booking to redeem, this endpoint performs the redemption.

```ruby
Ventrata::Redemption.redeem(redemptionCode: 'The redemption code or codes from the lookup call')
```

#### Redemption Credentials

In some cases where you might have multiple credentials on the same system that you redeem for, this endpoint is un-authenticated where you send the reference/barcode and a list of credentials, and we will return the most appropriate.

```ruby
Ventrata::Redemption.credentials(reference: 'HTA89203', apiKeys: ["5bd1629a-323e-4edb-ac9b-327ef51e6136"])
```

#### Redemption Validation

```ruby
Ventrata::Redemption.validate(redemptionCode: 'The redemption code or codes from the lookup call')
```

### Checkin

By default, all `Ventrata::Checkin` requests add capabality `octo/checkin` to your `Octo-Capabilities` header.

#### Lookup

Takes either an email, mobile or reference number and searches for the booking.

```ruby
Ventrata::Checkin.lookup(email: 'test@example.com')
```

##### Capabilities

- identities

Body:

- identityId (identities)
- identityKey (identities)

```ruby
Ventrata::Checkin.lookup(identityId: 'identityId', identityKey: 'identityKey', capabilities: [:identities])
```

### Identity

By default, all `Ventrata::Identity` requests add capabality `octo/identities` to your `Octo-Capabilities` header.

#### Create Identity

```ruby
Ventrata::Identity.create(key: 'Key of the identity in the external system', data: 'A key/value store for any data you want to store against this identity')
```

#### Update Identity

```ruby
Ventrata::Identity.update('id', key: 'Key of the identity in the external system', data: 'A key/value store for any data you want to store against this identity')
```
