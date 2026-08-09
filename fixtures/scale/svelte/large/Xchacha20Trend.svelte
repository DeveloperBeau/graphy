<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForXchacha20(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="xchacha20-trend">
  <TrendSparkline />
  <p>{trendForXchacha20(rows)}</p>
</div>

<style>
  .xchacha20-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
