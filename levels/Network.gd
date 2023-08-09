extends Node

var socket : PhoenixSocket
var channel : PhoenixChannel
var presence : PhoenixPresence


#var my_socket = PhoenixSocket.new("ws://localhost:4000/socket", {params = {user_id = 10, token = "some_token"}})
##
### Subscribe to Socket events
##socket.connect("on_open", self, "_on_Socket_open")
##socket.connect("on_close", self, "_on_Socket_close")
##socket.connect("on_error", self, "_on_Socket_error")
##socket.connect("on_connecting", self, "_on_Socket_connecting")
##
### If you want to track Presence
##presence = PhoenixPresence.new()
##
### Subscribe to Presence events (sync_diff and sync_state are also implemented)
##presence.connect("on_join", self, "_on_Presence_join")
##presence.connect("on_leave", self, "_on_Presence_leave")
##
### Create a Channel
##channel = socket.channel("game:abc", {}, presence)
##
### Subscribe to Channel events
##channel.connect("on_event", self, "_on_Channel_event")
##channel.connect("on_join_result", self, "_on_Channel_join_result")
##channel.connect("on_error", self, "_on_Channel_error")
##channel.connect("on_close", self, "_on_Channel_close")
##
##call_deferred("add_child", socket, true)
##
### Connect!
##socket.connect_socket()

func _on_socket_open(payload):
	channel.join()
	print("_on_Socket_open: ", " ", payload)

func _on_socket_close(payload):
	print("_on_Socket_close: ", " ", payload)

func _on_socket_error(payload):
	print("_on_Socket_error: ", " ", payload)

func _on_socket_connecting(is_connecting):
	print("_on_Socket_connecting: ", " ", is_connecting)

# Called when the node enters the scene tree for the first time.
#func _ready():
#	socket = PhoenixSocket.new("ws://localhost:4000/socket", { params = {user_id = 10, token = "some_token"}})
#
#	# Subscribe to Socket events
#	socket.connect("on_open", self, "_on_Socket_open")
#	socket.connect("on_close", self, "_on_Socket_close")
#	socket.connect("on_error", self, "_on_Socket_error")
#	socket.connect("on_connecting", self, "_on_Socket_connecting")
#
#	# If you want to track Presence
#	presence = PhoenixPresence.new()
#
#	# Subscribe to Presence events (sync_diff and sync_state are also implemented)
#	presence.connect("on_join", self, "_on_Presence_join")
#	presence.connect("on_leave", self, "_on_Presence_leave")
#
#	# Create a Channel
#	channel = socket.channel("game:abc", {}, presence)
#
#	# Subscribe to Channel events
#	channel.connect("on_event", self, "_on_Channel_event")
#	channel.connect("on_join_result", self, "_on_Channel_join_result")
#	channel.connect("on_error", self, "_on_Channel_error")
#	channel.connect("on_close", self, "_on_Channel_close")
#
#	call_deferred("add_child", socket, true)
#
#	# Connect!
#	socket.connect_socket()
#	pass # Replace with function body.
func _ready():
	print("42")
	socket = PhoenixSocket.new("ws://127.0.0.1:4000/socket", {params = {user_id = 10, token = "some_token"}})
	socket.connect("on_close", _on_socket_close)
	socket.connect("on_error", _on_socket_error)
	socket.connect("on_connecting", _on_socket_connecting)
	
# If you want to track Presence
	presence = PhoenixPresence.new()

# Subscribe to Presence events (sync_diff and sync_state are also implemented)
	presence.connect("on_join", _on_Presence_join)
	presence.connect("on_leave", _on_Presence_leave)

# Create a Channel
	channel = socket.channel("game:abc", {}, presence)

# Subscribe to Channel events
	channel.connect("on_event", _on_Channel_event)
	channel.connect("on_join_result", _on_Channel_join_result)
	channel.connect("on_error", _on_Channel_error)	
	channel.connect("on_close", _on_Channel_close)

	call_deferred("add_child", socket, true)
	socket.connect_socket()
	print("43")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#
# Socket events
#

#
# Channel events
#

func _on_Channel_event(event, payload, status):
	print("_on_Channel_event:  ", event, ", ", status, ", ", payload)

func _on_Channel_join_result(status, result):
	print("_on_Channel_join_result:  ", status, result)

func _on_Channel_error(error):
	print("_on_Channel_error: " + str(error))

func _on_Channel_close(closed):
	print("_on_Channel_close: " + str(closed))

#
# Presence events
#

func _on_Presence_join(joins):
	print("_on_Presence_join: " + str(joins))

func _on_Presence_leave(leaves):
	print("_on_Presence_leave: " + str(leaves))
