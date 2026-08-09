<script>
  import Misty1Panel from './Misty1Panel.svelte';
  import KasumiPanel from './KasumiPanel.svelte';
  import NoekeonPanel from './NoekeonPanel.svelte';
  import Shacal2Panel from './Shacal2Panel.svelte';
  import KhazadPanel from './KhazadPanel.svelte';
  import AnubisPanel from './AnubisPanel.svelte';
  import SquarePanel from './SquarePanel.svelte';
  import SharkPanel from './SharkPanel.svelte';

  export let rows = [];

  function orderHardwarePanels(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hardware-section">
  <Misty1Panel />
  <KasumiPanel />
  <NoekeonPanel />
  <Shacal2Panel />
  <KhazadPanel />
  <AnubisPanel />
  <SquarePanel />
  <SharkPanel />
  <p>{orderHardwarePanels(rows)}</p>
</div>

<style>
  .hardware-section {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
