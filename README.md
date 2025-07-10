# FayrShare

FayrShare is a simple and intuitive cost-splitting app designed to help friends manage shared expenses effortlessly.

## Getting Started

Follow these steps to set up and run the application locally.

Install dependencies using mix:
> mix deps.get

Run tests with:
> mix test

Launch the application server with:
> mix run --no-halt

The server should now be running on http://localhost:3000.

## Testing

Integration tests are executed against an [SQL Sandbox](http://hexdocs.pm/ecto_sql/Ecto.Adapters.SQL.Sandbox.html).
Therefore, the database needs to be initialised with 
```
MIX_ENV=test mix ecto.create
MIX_ENV=test mix ecto.migrate
```
