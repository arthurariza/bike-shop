# Bike Shop API
## Requirements
[REQUIREMENTS.md](REQUIREMENTS.md)

## Getting Started
### 1. Clone Repository
```
git clone git@github.com:arthurariza/bike-shop.git
cd bike-shop
```
### 2. Build docker images
```
docker compose build --no-cache
```
### 3. Start containers in background
```
docker compose up -d
```
### 4. Run database setup
```
docker compose exec api rails db:prepare
```
### 5. The server should be running on port 3000

## Sample Endpoints:
`Sample endpoints are included in the endpoints.json file`

## How To Run Specs
```
docker compose exec api rspec -fd
```
## Stop Containers Running In Background
```
docker compose stop
```

## Technical Decisions and Tradeoffs

### Architecture Decisions

1. **Service Objects Pattern**
   - Decision: Used service objects (e.g., `AddPurchasableService`, `RemovePurchasableService`) for complex business logic
   - Benefits: 
     - Keeps controllers thin and focused on HTTP concerns
     - Improves testability and reusability
     - Makes business logic explicit and isolated
   - Tradeoffs:
     - Adds extra abstraction layer
     - Requires more files and initial setup

2. **API Versioning**
   - Decision: Implemented versioned API endpoints (V1 namespace)
   - Benefits:
     - Allows for future API changes without breaking existing clients
     - Clear separation of different API versions
   - Tradeoffs:
     - Additional routing complexity
     - Need to maintain multiple versions if changes are made

3. **RESTful Resource Design**
   - Decision: Followed REST principles for resource naming and actions
   - Benefits:
     - Consistent and predictable API interface
     - Standard HTTP methods for operations
   - Tradeoffs:
     - Some complex operations might not fit REST perfectly
     - May require additional endpoints for specialized operations

### Data Model Decisions

1. **Polymorphic Associations**
   - Decision: Used polymorphic association for cart items (`purchasable`)
   - Benefits:
     - Flexible design that handles both products and customizations
     - DRY implementation for shared behavior
   - Tradeoffs:
     - More complex queries for calculating totals
     - Requires careful handling of joins and type-specific logic

2. **Database Schema Design**
   - Decision: Separate tables for products and customizations with shared interfaces
   - Benefits:
     - Clear separation of concerns
     - Allows for different attributes per type
   - Tradeoffs:
     - More complex queries for combined operations
     - Need to maintain consistency across related tables

### Performance Decisions

1. **Cart Total Price Calculation**
   - Decision: Used SQL-based calculation with LEFT JOINs
   - Benefits:
     - Avoids N+1 queries
     - Performs calculations in the database
   - Tradeoffs:
     - More complex SQL
     - Requires careful decimal handling

2. **Eager Loading**
   - Decision: Implemented strategic eager loading for cart items and their purchasables
   - Benefits:
     - Reduces N+1 queries
     - Improves response time for cart operations
   - Tradeoffs:
     - May load unnecessary data in some cases
     - Requires careful consideration of include statements

### Technical Considerations

1. **Decimal Handling**
   - Used BigDecimal with Float::DIG precision
   - Ensures accurate price calculations without floating-point errors
   - Important for financial calculations

2. **Error Handling**
   - Explicit error messages for business rules (stock, prohibited combinations)
   - Returns appropriate HTTP status codes
   - Consistent error format across endpoints

3. **Testing Strategy**
   - Unit tests for models and services
   - Controller tests with mocked services
   - Focus on behavior rather than implementation details

### Security Considerations

1. **Cart Access**
   - Current implementation uses a simple first/create approach
   - In production, would need proper user authentication and session management

2. **Input Validation**
   - Strong parameters in controllers
   - Model-level validations
   - Type checking for polymorphic associations

