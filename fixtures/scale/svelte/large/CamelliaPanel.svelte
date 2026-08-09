<script>
  import CamelliaTrend from './CamelliaTrend.svelte';
  import CamelliaDetail from './CamelliaDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeCamellia(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="camellia-panel">
  <CamelliaTrend />
  <CamelliaDetail />
  <CipherBadge />
  <p>{summarizeCamellia(rows)}</p>
</div>

<style>
  .camellia-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
