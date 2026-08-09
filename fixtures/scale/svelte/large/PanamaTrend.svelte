<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForPanama(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="panama-trend">
  <TrendSparkline />
  <p>{trendForPanama(rows)}</p>
</div>

<style>
  .panama-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
