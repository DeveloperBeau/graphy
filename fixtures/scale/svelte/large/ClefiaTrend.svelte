<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForClefia(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="clefia-trend">
  <TrendSparkline />
  <p>{trendForClefia(rows)}</p>
</div>

<style>
  .clefia-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
