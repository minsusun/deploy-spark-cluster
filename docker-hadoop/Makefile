current_branch := "latest"
build:
	docker build -t base:$(current_branch) ./base
	docker build -t namenode:$(current_branch) ./namenode
	docker build -t datanode:$(current_branch) ./datanode
	docker build -t resourcemanager:$(current_branch) ./resourcemanager
	docker build -t nodemanager:$(current_branch) ./nodemanager
	docker build -t historyserver:$(current_branch) ./historyserver
