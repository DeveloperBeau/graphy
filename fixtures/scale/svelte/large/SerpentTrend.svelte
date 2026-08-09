<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSerpent(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="serpent-trend">
  <TrendSparkline />
  <p>{trendForSerpent(rows)}</p>
</div>

<style>
  .serpent-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
