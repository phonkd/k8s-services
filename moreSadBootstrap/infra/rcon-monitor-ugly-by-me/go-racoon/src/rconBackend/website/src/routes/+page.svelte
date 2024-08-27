<!-- YOU CAN DELETE EVERYTHING IN THIS PAGE -->
<script>
	import TerminalInput from "../TerminalInput.svelte";
	import { LightSwitch } from '@skeletonlabs/skeleton';
	let commandResult = '';
  </script>
  
<div class="container h-full mx-auto flex justify-center">
	<div class="space-y-5">
		<div class="idk"><LightSwitch 
			rounded="rounded-lg"
		/>
		</div>
		<h1 class="h1">Minecraft RCON terminal</h1>
		<p>Command:</p>
		<ul>
			<TerminalInput />
			
		</ul>
	</div>
	<div class="command-output">
		<pre>{commandResult}</pre>
	</div>
</div>
<style>
    .space-y-5 {
        margin-top: 50px;
    }
	.idk {
		display: flex;
		justify-content: flex-end;
		margin-right: 9%
	}
</style>
