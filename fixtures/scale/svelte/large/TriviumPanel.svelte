<script>
  import TriviumTrend from './TriviumTrend.svelte';
  import TriviumDetail from './TriviumDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeTrivium(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="trivium-panel">
  <TriviumTrend />
  <TriviumDetail />
  <CipherBadge />
  <p>{summarizeTrivium(rows)}</p>
</div>

<style>
  .trivium-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
