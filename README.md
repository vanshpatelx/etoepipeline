# 🚀 CI Pipeline for Monorepo  

## 📜 Overview  

1. **Code Checkout**: Retrieves the latest code from GitHub.  
2. **Environment Setup**: Configures Node.js and GoLang for the monorepo.  
3. **Dependency Installation**: Installs required dependencies for each service.  
4. **Docker Resource Setup**: Spins up required services using Docker Compose.  
5. **Testing**: Runs unit and integration tests.  
6. **Multi-Stage Docker Image Build**: Builds images for all services.  
7. **Docker Compose Testing**: Validates Docker images in a containerized environment.  
8. **Publishing to DockerHub**: Pushes built images to DockerHub for deployment.  

---

## 📊 Architecture Diagram  

![CI/CD Pipeline Diagram](https://github.com/vanshpatelx/etoepipeline/blob/main/image/flow.png)  


## 🛠️ GitHub Actions Workflow  

### **Trigger**  
- Runs on every push to the `main` branch.  

### **Jobs & Steps**  

| Step | Description |
|------|------------|
| **Checkout Code** | Clones the repository. |
| **Setup Node.js** | Configures the Node.js environment. |
| **Setup GoLang** | Configures the Go environment. |
| **Install Dependencies** | Installs dependencies for all services. |
| **Configure Resources** | Runs a script to set up required resources using Docker. |
| **Start Turbo Development** | Starts TurboRepo's development server in the background. |
| **Run Tests** | Executes test cases for each package. |
| **Cleanup Resources** | Stops running processes and cleans up. |
| **Build Docker Images** | Builds service images using Docker. |
| **Test Docker Compose Setup** | Ensures the containerized environment works as expected. |
| **Push Docker Images** | Publishes images to DockerHub. |

---
Would you like any modifications or enhancements? 😊