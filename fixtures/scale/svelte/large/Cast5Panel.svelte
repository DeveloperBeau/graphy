<script>
  import Cast5Trend from './Cast5Trend.svelte';
  import Cast5Detail from './Cast5Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeCast5(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="cast5-panel">
  <Cast5Trend />
  <Cast5Detail />
  <CipherBadge />
  <p>{summarizeCast5(rows)}</p>
</div>

<style>
  .cast5-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
