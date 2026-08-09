<script>
  import Chacha20Panel from './Chacha20Panel.svelte';
  import Xchacha20Panel from './Xchacha20Panel.svelte';
  import Salsa20Panel from './Salsa20Panel.svelte';
  import SosemanukPanel from './SosemanukPanel.svelte';
  import RabbitPanel from './RabbitPanel.svelte';
  import Snow3gPanel from './Snow3gPanel.svelte';
  import ZucPanel from './ZucPanel.svelte';
  import GrainPanel from './GrainPanel.svelte';

  export let rows = [];

  function orderStreamPanels(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="stream-section">
  <Chacha20Panel />
  <Xchacha20Panel />
  <Salsa20Panel />
  <SosemanukPanel />
  <RabbitPanel />
  <Snow3gPanel />
  <ZucPanel />
  <GrainPanel />
  <p>{orderStreamPanels(rows)}</p>
</div>

<style>
  .stream-section {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
