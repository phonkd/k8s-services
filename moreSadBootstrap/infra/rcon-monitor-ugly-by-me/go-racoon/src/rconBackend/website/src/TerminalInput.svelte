<!-- TerminalInput.svelte -->
<script>
    let command = "";
    let result = "Awaiting command..."; // default message
    let host = localStorage.getItem('host') || '';
    let port = localStorage.getItem('port') || '';
    let password = "";   // Added
    function saveToLocalStorage() {
        localStorage.setItem('host', host);
        localStorage.setItem('port', port);
    }
    async function handleSubmit() {
        // Handle the command submission
        // When you receive the result from the server:
        // result = ...your response from the server...;
        const url = `/rcon`;
        console.log("huan")
        const payload = {
            "command": command,
            "host": `${host}:${port}`,
            "password": password
        };
        console.log(payload);
        // try {
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload)
                
            });

            if (response.ok) {
                const data = await response.json();
                result += "\n" +  data.response
            } else {
                result = `Error 1: ${response.statusText}`;
            }
}


    
</script>

<style>
    .terminal-input {
        width: 600px;
        border: 1px solid #333;
        padding: 10px;
        background-color: #222;
        color: limegreen;
        font-family: "Courier New", monospace;
        border-radius: 8px;
        margin-top: 10px;
    }

    .command-output {
        margin-top: 10px;
        width: 600px;
        padding: 10px;
        border: 1px solid #333;
        background-color: #222;
        color: rgb(201, 120, 79);
        font-family: "Courier New", monospace;
        border-radius: 8px;
        height: 500px; /* set a fixed height so it's always visible */
        overflow: auto; /* in case content becomes too long */
    }
    .input-field {
        margin-bottom: 10px;
        padding: 5px;
        width: 100%;
        box-sizing: border-box;
        border: 1px solid #333;
        background-color: #222;
        color: rgb(201, 120, 79);
        font-family: "Courier New", monospace;
        border-radius: 8px;
    }
    .flex-container {
        display: flex;
        /* gap: 10px; */
    }
    .flex-container > input {
        flex: 1; /* Makes the inputs take up equal width */
    }
    .port {
        max-width: 15%;
        margin-right: 16px;
    }
    .host {
        max-width: 30%;
        margin-right: 3px;
        
        
    }
    .password {
        max-width: 43%;
    }
</style>


<div class="flex-container">
    <input 
        class="input-field host"
        type="text" 
        bind:value={host} 
        placeholder="Enter host..."
	on:input={saveToLocalStorage}
    />

    <input 
        class="input-field port"
        type="text" 
        bind:value={port} 
        placeholder="Port"
	on:input={saveToLocalStorage}
    />
    <input 
    class="input-field password"
    type="password" 
    bind:value={password} 
    placeholder="Enter password..."
/>
</div>


<!-- Input for Port -->


<div class="command-output">
    <pre>{result}</pre>
</div>

<input 
    class="terminal-input" 
    type="text" 
    bind:value={command} 
    placeholder="Enter command..." 
    on:keydown={(e) => e.key === 'Enter' && handleSubmit()}
/>



