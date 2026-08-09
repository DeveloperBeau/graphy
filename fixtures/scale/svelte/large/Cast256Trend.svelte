<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForCast256(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="cast256-trend">
  <TrendSparkline />
  <p>{trendForCast256(rows)}</p>
</div>

<style>
  .cast256-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
