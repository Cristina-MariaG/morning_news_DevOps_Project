from locust import HttpUser, task

class First_Load_Test(HttpUser):
    @task
    def first_test(self):
        self.client.get("/")