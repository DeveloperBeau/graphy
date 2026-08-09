<script>
  import Xchacha20Trend from './Xchacha20Trend.svelte';
  import Xchacha20Detail from './Xchacha20Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeXchacha20(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="xchacha20-panel">
  <Xchacha20Trend />
  <Xchacha20Detail />
  <CipherBadge />
  <p>{summarizeXchacha20(rows)}</p>
</div>

<style>
  .xchacha20-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
