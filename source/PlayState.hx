package;

import flixel.FlxState;
import networking.Network;
import networking.utils.NetworkEvent;
import networking.utils.NetworkMode;

class PlayState extends FlxState
{
	var newestID:Int;

	override public function create()
	{
		newestID = 0;
		var server = Network.registerSession(NetworkMode.SERVER, {ip: "0.0.0.0", port: 8888, flash_policy_file_port: 9999});
		server.addEventListener(NetworkEvent.MESSAGE_RECEIVED, function(event:NetworkEvent)
		{
			switch (event.data.case1)
			{
				case "player_joined":
					server.send({case1: "new_player", playerID: newestID});
					trace("Sended");
					newestID += 1;
			}
		});
		server.start();
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
