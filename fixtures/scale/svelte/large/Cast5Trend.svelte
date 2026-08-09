<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForCast5(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="cast5-trend">
  <TrendSparkline />
  <p>{trendForCast5(rows)}</p>
</div>

<style>
  .cast5-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
