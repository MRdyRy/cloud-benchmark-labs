# syntax=docker/dockerfile:1

# -----------------------------
# 1. Build stage (GraalVM Native Image)
# -----------------------------
FROM ghcr.io/graalvm/native-image-community:21 AS builder

WORKDIR /app

# Install build tools required by Quarkus native build
RUN microdnf install -y \
    tar \
    gzip \
    findutils \
    gcc \
    glibc-devel \
    zlib-devel \
    && microdnf clean all

# Copy Maven wrapper first (for caching)
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Download dependencies (cached layer)
RUN ./mvnw -B dependency:go-offline

# Copy source
COPY src ./src

# Build native executable
RUN ./mvnw package -Pnative -DskipTests

# -----------------------------
# 2. Runtime stage (minimal Quarkus image)
# -----------------------------
FROM gcr.io/distroless/base-debian12:nonroot

WORKDIR /app

# Copy native binary (Quarkus naming convention)
COPY --from=builder /app/target/*-runner /app/user-svc-quarkus

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/app/user-svc-quarkus", "-Dquarkus.http.host=0.0.0.0"]