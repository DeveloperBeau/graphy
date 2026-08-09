<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForBaseking(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="baseking-trend">
  <TrendSparkline />
  <p>{trendForBaseking(rows)}</p>
</div>

<style>
  .baseking-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
