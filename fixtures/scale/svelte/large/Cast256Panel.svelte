<script>
  import Cast256Trend from './Cast256Trend.svelte';
  import Cast256Detail from './Cast256Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeCast256(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="cast256-panel">
  <Cast256Trend />
  <Cast256Detail />
  <CipherBadge />
  <p>{summarizeCast256(rows)}</p>
</div>

<style>
  .cast256-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
