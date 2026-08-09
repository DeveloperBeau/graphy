<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForHight(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hight-trend">
  <TrendSparkline />
  <p>{trendForHight(rows)}</p>
</div>

<style>
  .hight-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
