<script>
  import Snow3gTrend from './Snow3gTrend.svelte';
  import Snow3gDetail from './Snow3gDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSnow3g(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="snow3g-panel">
  <Snow3gTrend />
  <Snow3gDetail />
  <CipherBadge />
  <p>{summarizeSnow3g(rows)}</p>
</div>

<style>
  .snow3g-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
