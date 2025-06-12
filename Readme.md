# Cloud Architecture Overview – Innovate Inc.

This document describes the cloud infrastructure architecture designed for Innovate Inc. Our goal is to provide a scalable, secure, and easy-to-operate foundation for a modern web application that includes a React frontend, Flask backend, and PostgreSQL database—all running on Kubernetes.

---

## 1. Cloud Environment Structure

To follow best practices for isolation, governance, and cost visibility, we recommend setting up **three separate AWS accounts** (or GCP projects if working with Google Cloud):

- **Production**: For live workloads serving real users.
- **Staging**: For final integration tests before production deployment.
- **Development**: For individual or team testing environments, and CI/CD operations.

This model provides strong separation of concerns, improves security boundaries, and enables more precise budgeting per environment.

---

## 2. Network Design

### VPC Layout

Each environment (prod, staging, dev) should have its own Virtual Private Cloud. Within each VPC:

- **3 public subnets**, across different availability zones – primarily for load balancers and NAT gateways.
- **3 private subnets**, also across AZs – used for application workloads and databases.

This ensures high availability and fault tolerance by design.

### Security Measures

- **Security Groups** are used to restrict traffic between components, ensuring the principle of least privilege.
- **Network ACLs** provide a second layer of control between subnets.
- **VPC Endpoints** are configured to allow private access to services like S3 without routing traffic through the public internet.
- **NAT Gateways** give private subnets secure, outbound-only internet access.

---

## 3. Compute Platform

### Kubernetes Deployment

The application runs on **Amazon EKS** (or Google Kubernetes Engine if on GCP). We rely on the managed control plane to reduce operational complexity.

### Node Management

- Node groups are separated by workload profile:
  - Compute-optimized (e.g. backend API)
  - Memory-optimized (e.g. cache, analysis jobs)
  - General-purpose (e.g. frontend, batch jobs)
- **Karpenter** handles dynamic scaling of worker nodes.
- We support both **x86** and **ARM (Graviton)** instance types to optimize cost and performance.
- Spot instances are used where appropriate to reduce compute costs.

### Containerization Workflow

- All services are containerized with Docker and built using CI pipelines.
- Images are pushed to **Amazon ECR** and deployed using Helm charts.
- Deployment is automated and integrates with GitHub Actions.

---

## 4. Database Layer

### PostgreSQL Strategy

We recommend using **Amazon RDS for PostgreSQL** due to its maturity, operational simplicity, and built-in HA features.

Why RDS?

- Automated failover with Multi-AZ.
- Point-in-time recovery.
- Integrated monitoring and logging.
- TLS encryption in transit and at rest.

### High Availability & Disaster Recovery

- Multi-AZ deployment for failover support.
- Read replicas to handle read-heavy workloads.
- Scheduled backups with retention policies.
- Manual snapshots before major upgrades or migrations.

---

## Final Notes

This architecture reflects practical experience managing cloud-native platforms in production. It balances security, scalability, and ease of management, while maintaining cost awareness.

The design is modular and adaptable, giving Innovate Inc. the flexibility to evolve its platform as business needs grow.

---
