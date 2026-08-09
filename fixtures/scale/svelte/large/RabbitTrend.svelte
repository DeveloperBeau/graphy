<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForRabbit(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rabbit-trend">
  <TrendSparkline />
  <p>{trendForRabbit(rows)}</p>
</div>

<style>
  .rabbit-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
