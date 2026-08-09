<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForShark(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="shark-trend">
  <TrendSparkline />
  <p>{trendForShark(rows)}</p>
</div>

<style>
  .shark-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
