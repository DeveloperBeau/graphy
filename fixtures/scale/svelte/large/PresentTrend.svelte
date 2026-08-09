<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForPresent(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="present-trend">
  <TrendSparkline />
  <p>{trendForPresent(rows)}</p>
</div>

<style>
  .present-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
