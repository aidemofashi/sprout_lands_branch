class_name NodeStateMachine #类名 NodeStateMachine 节点状态机
extends Node #继承自node

@export var initial_node_state : NodeState # 向外输出指定变量的接口，类型得为NodeState类型

var node_states : Dictionary = {} #定义变量来储存检测到的状态节点
var current_node_state : NodeState #当前节点，格式为nodestate格式
var current_node_state_name : String #当前节点的名字

func _ready() -> void: #准备函数，运用godot _ready 方法，每次启动游戏时自动执行一次
	for child in get_children(): #循环child，返回该节点的所有子节点到一个 Array 内。
		if child is NodeState: #如果节点类型为NodeState
			node_states[child.name.to_lower()] = child #将节点名字转为小写保存到node_states 数组中 
			child.transition.connect(transition_to) # 
	
	if initial_node_state: #如果当前有预选的节点
		initial_node_state._on_enter() #调用当前预选的节点
		current_node_state = initial_node_state #把当前节点设置为预选节点


func _process(delta : float) -> void: #定义函数，调用_process方法，每一帧执行一次
	if current_node_state: #如果有当前节点
		current_node_state._on_process(delta) #每一帧调用一次当前节点


func _physics_process(delta: float) -> void: #定义函数，调用_physics_process方法  
	if current_node_state: #如果当前节点存在
		current_node_state._on_physics_process(delta) #每一次物理帧时间调用一次当前选择的节点的_on_physics_process
		current_node_state._on_next_transitions() #然后调用当前节点的_on_next_transitions方法


func transition_to(node_state_name : String) -> void: #定义transition_to函数，用来切换到下一个状态节点
	if node_state_name == current_node_state.name.to_lower(): #如果要切换的状态节点名字等于当前状态节点名字时结束函数
		return
	
	var new_node_state = node_states.get(node_state_name.to_lower()) #定义一个变量，用来存储要切换的状态节点的小写名称
	
	if !new_node_state: #如果指定要切换的状态节点不存在，则结束函数
		return
	
	if current_node_state: #如果当前状态节点存在，则结束状态
		current_node_state._on_exit()
	
	new_node_state._on_enter() #调用新的状态
	
	current_node_state = new_node_state #当前状态节点变为新的转台节点
	current_node_state_name = current_node_state.name.to_lower() #当前状态节点的名称调用并赋值
	print("Current State: ", current_node_state_name) #输出信息，输出当前状态节点的名称
