<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForHc256(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hc256-trend">
  <TrendSparkline />
  <p>{trendForHc256(rows)}</p>
</div>

<style>
  .hc256-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
