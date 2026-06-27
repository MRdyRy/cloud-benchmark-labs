# syntax=docker/dockerfile:1

# -----------------------------
# 1. Build stage
# -----------------------------
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Install CA certs + git (for private/public deps)
RUN apk add --no-cache git ca-certificates

# Enable Go modules
ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Copy dependency files first (better caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy source
COPY . .

# Build static binary
RUN go build -trimpath -ldflags="-s -w" -o user-svc-go ./cmd/user-svc

# -----------------------------
# 2. Runtime stage
# -----------------------------
FROM gcr.io/distroless/static:nonroot

WORKDIR /app

# Copy CA certificates (needed for HTTPS calls)
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy binary
COPY --from=builder /app/user-svc-go /user-svc-go

USER nonroot:nonroot

EXPOSE 8080

ENTRYPOINT ["/user-svc-go"] 