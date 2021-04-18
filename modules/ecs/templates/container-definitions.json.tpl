[
    {
        "name": "nginx",
        "image": "${app_image}",
        "essential": true,
        "memoryReservation": 256,
        "environment": [],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}",
                "awslogs-stream-prefix": "webserver"
            }
        },
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80
            }
        ],
        "mountPoints": []
    }
]
