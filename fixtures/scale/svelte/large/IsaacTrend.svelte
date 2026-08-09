<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForIsaac(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="isaac-trend">
  <TrendSparkline />
  <p>{trendForIsaac(rows)}</p>
</div>

<style>
  .isaac-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
