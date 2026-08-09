<script>
  import AesPanel from './AesPanel.svelte';
  import SerpentPanel from './SerpentPanel.svelte';
  import TwofishPanel from './TwofishPanel.svelte';
  import CamelliaPanel from './CamelliaPanel.svelte';
  import AriaPanel from './AriaPanel.svelte';
  import Sm4Panel from './Sm4Panel.svelte';
  import KuznyechikPanel from './KuznyechikPanel.svelte';
  import ClefiaPanel from './ClefiaPanel.svelte';

  export let rows = [];

  function orderModernPanels(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="modern-section">
  <AesPanel />
  <SerpentPanel />
  <TwofishPanel />
  <CamelliaPanel />
  <AriaPanel />
  <Sm4Panel />
  <KuznyechikPanel />
  <ClefiaPanel />
  <p>{orderModernPanels(rows)}</p>
</div>

<style>
  .modern-section {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
