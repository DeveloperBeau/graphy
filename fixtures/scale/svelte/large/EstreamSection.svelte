<script>
  import Hc128Panel from './Hc128Panel.svelte';
  import Hc256Panel from './Hc256Panel.svelte';
  import TriviumPanel from './TriviumPanel.svelte';
  import Mickey2Panel from './Mickey2Panel.svelte';

  export let rows = [];

  function orderEstreamPanels(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="estream-section">
  <Hc128Panel />
  <Hc256Panel />
  <TriviumPanel />
  <Mickey2Panel />
  <p>{orderEstreamPanels(rows)}</p>
</div>

<style>
  .estream-section {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
