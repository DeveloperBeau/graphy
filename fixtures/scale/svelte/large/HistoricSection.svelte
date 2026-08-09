<script>
  import FealPanel from './FealPanel.svelte';
  import LuciferPanel from './LuciferPanel.svelte';
  import ThreewayPanel from './ThreewayPanel.svelte';
  import BasekingPanel from './BasekingPanel.svelte';
  import Rc4Panel from './Rc4Panel.svelte';
  import SealPanel from './SealPanel.svelte';
  import PanamaPanel from './PanamaPanel.svelte';
  import IsaacPanel from './IsaacPanel.svelte';

  export let rows = [];

  function orderHistoricPanels(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="historic-section">
  <FealPanel />
  <LuciferPanel />
  <ThreewayPanel />
  <BasekingPanel />
  <Rc4Panel />
  <SealPanel />
  <PanamaPanel />
  <IsaacPanel />
  <p>{orderHistoricPanels(rows)}</p>
</div>

<style>
  .historic-section {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
