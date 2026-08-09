<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForHc128(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hc128-trend">
  <TrendSparkline />
  <p>{trendForHc128(rows)}</p>
</div>

<style>
  .hc128-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
